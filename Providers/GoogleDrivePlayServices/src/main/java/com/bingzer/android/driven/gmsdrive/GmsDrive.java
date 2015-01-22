package com.bingzer.android.driven.gmsdrive;

import android.content.Context;

import com.bingzer.android.driven.AbsStorageProvider;
import com.bingzer.android.driven.Credential;
import com.bingzer.android.driven.DefaultUserInfo;
import com.bingzer.android.driven.DrivenException;
import com.bingzer.android.driven.LocalFile;
import com.bingzer.android.driven.Permission;
import com.bingzer.android.driven.RemoteFile;
import com.bingzer.android.driven.Result;
import com.bingzer.android.driven.UserInfo;
import com.bingzer.android.driven.contracts.Search;
import com.bingzer.android.driven.contracts.SharedWithMe;
import com.bingzer.android.driven.contracts.Sharing;
import com.bingzer.android.driven.contracts.Trashed;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.drive.Drive;
import com.google.android.gms.drive.DriveApi;
import com.google.android.gms.drive.Metadata;
import com.google.android.gms.drive.query.Filters;
import com.google.android.gms.drive.query.Query;
import com.google.android.gms.drive.query.SearchableField;
import com.google.android.gms.plus.Plus;

import java.util.ArrayList;
import java.util.List;

/**
 * GoogleDrive Storage Provider that uses DriveApi inside the GooglePlayServices
 */
public class GmsDrive extends AbsStorageProvider /*implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener */{

    public static final int RC_SIGN_IN = 411;

    private static GoogleApiClient apiClient;
    private UserInfo userInfo;

    @Override
    public UserInfo getUserInfo() {
        return userInfo;
    }

    @Override
    public boolean isAuthenticated() {
        return apiClient != null && userInfo != null;
    }

    @Override
    public Result<DrivenException> clearSavedCredential(Context context) {
        Result<DrivenException> result = new Result<DrivenException>(false);
        apiClient = null;
        userInfo = null;

        Credential credential = new Credential(context);
        credential.clear(getName());

        return result;
    }

    @Override
    public Result<DrivenException> authenticate(Credential credential) {
        Result<DrivenException> result = new Result<DrivenException>(false);
        try {
            if(credential == null) throw new DrivenException(new IllegalArgumentException("credential cannot be null"));

            GoogleApiClient.Builder clientBuilder = createApiClientBuilder(credential.getContext());
            if(credential.hasSavedCredential(getName())){
                credential.read(getName());
                clientBuilder.setAccountName(credential.getAccountName());
            }

            apiClient = clientBuilder.build();
            ConnectionResult connResult = apiClient.blockingConnect();

            if(connResult.getErrorCode() != ConnectionResult.SUCCESS){
                if(connResult.hasResolution() && credential instanceof GmsCredential){
                    ((GmsCredential) credential).getCallingActivity().startIntentSenderForResult(connResult.getResolution().getIntentSender(), RC_SIGN_IN, null, 0, 0, 0);
                }
                throw new RuntimeException("Unable to authenticate: ConnectionResult = " + connResult.getErrorCode());
            }

            // -- get account name from Google+
            credential.setAccountName(Plus.AccountApi.getAccountName(apiClient));

            userInfo = new GoogleDriveUser(credential.getAccountName(), credential.getAccountName(), null);

            result.setSuccess(true);

            // only save when it's not null
            if(credential.getAccountName() != null)
                credential.save(getName());
        }
        catch (Exception e){
            result.setException(new DrivenException(e));
            apiClient = null;
        }

        return result;
    }

    @Override
    public boolean exists(String name) {
        return false;
    }

    @Override
    public boolean exists(RemoteFile parent, String name) {
        return false;
    }

    @Override
    public Permission getPermission(RemoteFile remoteFile) {
        return null;
    }

    @Override
    public RemoteFile get(RemoteFile parent, String name) {
        return null;
    }

    @Override
    public RemoteFile get(String name) {
        return null;
    }

    @Override
    public RemoteFile id(String id) {
        return null;
    }

    @Override
    public RemoteFile getDetails(RemoteFile remoteFile) {
        return null;
    }

    @Override
    public List<RemoteFile> list() {
        Query query = new Query.Builder()
                .addFilter(Filters.eq(SearchableField.PARENTS, null))
                .build();
        Drive.DriveApi.query(apiClient, query);

        return null;
    }

    @Override
    public List<RemoteFile> list(RemoteFile parent) {
        List<RemoteFile> list = new ArrayList<>();
        Query query = new Query.Builder()
                .build();
        DriveApi.MetadataBufferResult bufferResult = Drive.DriveApi.query(apiClient, query).await();
        if (bufferResult.getStatus().isSuccess()){
            for (Metadata metadata : bufferResult.getMetadataBuffer()) {
                list.add(new GmsRemoteFile(this, metadata));
            }
        }

        return list;
    }

    @Override
    public RemoteFile create(String name) {
        return null;
    }

    @Override
    public RemoteFile create(LocalFile local) {
        return null;
    }

    @Override
    public RemoteFile create(RemoteFile parent, String name) {
        return null;
    }

    @Override
    public RemoteFile create(RemoteFile parent, LocalFile local) {
        return null;
    }

    @Override
    public RemoteFile update(RemoteFile remoteFile, LocalFile content) {
        return null;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public boolean download(RemoteFile remoteFile, LocalFile local) {
        return false;
    }

    @Override
    public Search getSearch() {
        return null;
    }

    @Override
    public SharedWithMe getShared() {
        return null;
    }

    @Override
    public Sharing getSharing() {
        return null;
    }

    @Override
    public Trashed getTrashed() {
        return null;
    }

    @Override
    public String getName() {
        return "Google Drive (PlayServices)";
    }

    //////////////////////////////////////////////////////////////////////////////////////////////

    private GoogleApiClient.Builder createApiClientBuilder(Context context){
        return new GoogleApiClient.Builder(context)
                .addApi(Drive.API)
                .addApi(Plus.API)
                .addScope(Drive.SCOPE_FILE)
                .addScope(Drive.SCOPE_APPFOLDER);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////

    class GoogleDriveUser extends DefaultUserInfo {

        protected GoogleDriveUser(String name, String displayName, String emailAddress){
            this.name = name;
            this.displayName = displayName;
            this.emailAddress = emailAddress;
        }
    }

}
