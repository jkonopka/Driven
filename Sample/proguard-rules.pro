# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in E:/android/android-sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the ProGuard
# include property in project.properties.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-verbose
#-dontobfuscate
#
#-dontshrink
#-dontoptimize
#-dontpreverify
#-dontnote

-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*
#-optimizationpasses 5
#-allowaccessmodification
#-dontpreverify
#-renamesourcefileattribute SourceFile
#-keepattributes *Annotation*
#-keepattributes SourceFile,LineNumberTable,Signature
## Obfuscation
#-repackageclasses ''
#-flattenpackagehierarchy ''


-keep class com.bingzer.android.driven.** { *; }

-keep class com.google.** { *;}
-keep interface com.google.** { *;}

-dontwarn sun.misc.Unsafe
-dontwarn com.google.common.collect.MinMaxPriorityQueue
-dontwarn com.google.android.gms.**
-keepattributes *Annotation*,Signature,EnclosingMethod
-keep class * extends com.google.api.client.json.GenericJson { *; }
-keep class com.google.api.services.drive.** { *; }

# ----

-dontwarn dagger.internal.codegen.**
-keepclassmembers,allowobfuscation class * {
    @javax.inject.* *;
    @dagger.* *;
    <init>();
}

-keep class dagger.* { *; }
-keep class javax.inject.* { *; }
-keep class * extends dagger.internal.Binding
-keep class * extends dagger.internal.ModuleAdapter
-keep class * extends dagger.internal.StaticInjection

# ---

# Retain generated class which implement ViewBinder.
#-keep public class * implements butterknife.internal.ViewBinder { public <init>(); }

# Prevent obfuscation of types which use ButterKnife annotations since the simple name
# is used to reflectively look up the generated ViewBinder.
#-keep class butterknife.*
#-keepclasseswithmembernames class * { @butterknife.* <methods>; }
#-keepclasseswithmembernames class * { @butterknife.* <fields>; }

-dontnote android.net.http.SslError
-dontnote android.net.http.SslCertificate$DName
-dontnote android.net.http.SslCertificate
-dontnote android.net.http.HttpResponseCache
-dontnote org.apache.http.conn.scheme.SocketFactory
-dontnote org.apache.http.conn.scheme.HostNameResolver
-dontnote org.apache.http.conn.scheme.LayeredSocketFactory
-dontnote org.apache.http.conn.ConnectTimeoutException
-dontnote org.apache.http.params.CoreConnectionPNames
-dontnote org.apache.http.params.HttpParams
-dontnote org.apache.http.params.HttpConnectionParams

# --
-keep class com.google.protobuf.zzc
-keep class com.google.protobuf.zzd
-keep class com.google.protobuf.zze

-keep class com.google.android.gms.dynamic.IObjectWrapper
-keep class com.google.android.gms.internal.zzuq
-keep class com.google.android.gms.internal.oo
-keep class com.google.android.gms.internal.oh
-keep class com.google.android.gms.internal.zzcgl
-keep class com.google.android.gms.internal.ql
-keep class com.google.android.gms.internal.zzcem
-keep class com.google.android.gms.tagmanager.zzce
-keep class com.google.android.gms.tagmanager.zzcn
-keep class com.google.android.gms.plus.PlusOneButton$OnPlusOneClickListener
-keep class com.google.android.gms.measurement.AppMeasurement$zza
-keep class com.google.android.gms.measurement.AppMeasurement$OnEventListener
-keep class com.google.android.gms.measurement.AppMeasurement$EventInterceptor

-keep class com.google.android.gms.ads.mediation.MediationAdRequest
-keep class com.google.android.gms.ads.mediation.MediationBannerListener
-keep class com.google.android.gms.ads.AdSize
-keep class com.google.android.gms.ads.mediation.MediationInterstitialListener
-keep class com.google.android.gms.ads.mediation.MediationNativeListener
-keep class com.google.android.gms.ads.reward.mediation.MediationRewardedVideoAdListener
-keep class com.google.android.gms.ads.InterstitialAd
-keep class com.google.android.gms.ads.AdListener
-keep class com.google.android.gms.ads.Correlator
-keep class com.google.android.gms.ads.formats.NativeAd
-keep class com.google.android.gms.ads.mediation.NativeMediationAdRequest
-keep class com.google.android.gms.ads.formats.MediaView
-keep class com.google.android.gms.ads.formats.AdChoicesView
-keep class com.google.android.gms.ads.mediation.NativeMediationAdRequest
-keep class com.google.android.gms.ads.VideoOptions
-keep class com.google.android.gms.ads.doubleclick.OnCustomRenderedAdLoadedListener
-keep class com.google.android.gms.ads.mediation.customevent.CustomEventInterstitialListener
-keep class com.google.android.gms.ads.doubleclick.AppEventListener
-keep class com.google.android.gms.ads.mediation.customevent.CustomEventBannerListener
-keep class com.google.android.gms.ads.mediation.customevent.CustomEventNativeListener
-keep class com.google.android.gms.ads.mediation.customevent.CustomEventExtras

-keep class com.google.ads.mediation.MediationServerParameters
-keep class com.google.ads.mediation.NetworkExtras
-keep class com.google.ads.mediation.MediationInterstitialListener
-keep class com.google.ads.mediation.customevent.CustomEventServerParameters
-keep class com.google.ads.mediation.MediationBannerListener
-keep class com.google.ads.AdSize
-keep class com.google.ads.mediation.MediationAdRequest
-keep class com.google.ads.mediation.customevent.CustomEventBannerListener
-keep class com.google.ads.mediation.customevent.CustomEventInterstitialListener

-keep class com.google.firebase.FirebaseApp
-keep class com.google.firebase.database.connection.idl.zzah
-keep class com.google.firebase.database.connection.idl.zzq
-keep class com.google.firebase.database.connection.idl.zzw
-keep class com.google.firebase.database.connection.idl.zzk

-dontnote com.google.protobuf.zzc
-dontnote com.google.protobuf.zzd
-dontnote com.google.protobuf.zze
-dontnote com.google.android.gms.internal.q
-dontnote com.google.android.gms.internal.zzcem

-keep class com.google.android.gms.cast.framework.OptionsProvider