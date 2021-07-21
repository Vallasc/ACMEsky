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
import { AccountService, NotificationService } from '../app/_services';
import {MatCardModule} from '@angular/material/card';

@NgModule({
    imports: [
        BrowserModule,
        ReactiveFormsModule,
        HttpClientModule,
        AppRoutingModule,
        ServiceWorkerModule.register('ngsw-worker.js', { enabled: environment.production }),
        MatCardModule
    ],
    declarations: [
        AppComponent,
        AlertComponent,
        NotificationComponent

    ],
    providers: [AccountService, NotificationService
    ],
    bootstrap: [AppComponent]
})
export class AppModule { };