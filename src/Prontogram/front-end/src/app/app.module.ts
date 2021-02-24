import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AlertComponent } from './_components';
import { HomeComponent } from './home';
import { NotificationComponent } from './notification';;
import { ServiceWorkerModule } from '@angular/service-worker'; 
import { environment } from '@environments/environment';

@NgModule({
    imports: [
        BrowserModule,
        ReactiveFormsModule,
        HttpClientModule,
        AppRoutingModule,
        ServiceWorkerModule.register('ngsw-worker.js', { enabled: environment.production }),
    ],
    declarations: [
        AppComponent,
        AlertComponent,
        HomeComponent,
        NotificationComponent
        
    ],
    providers: [
    ],
    bootstrap: [AppComponent]
})
export class AppModule { };