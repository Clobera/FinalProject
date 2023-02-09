import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './components/home/home.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NotfoundComponent } from './components/notfound/notfound.component';
import { NavbarComponent } from './components/navbar/navbar.component';
import { FooterComponent } from './components/footer/footer.component';
import { LoginComponent } from './components/login/login.component';
import { AccountComponent } from './components/account/account.component';
import { MygroupsComponent } from './components/mygroups/mygroups.component';
import { AlertsComponent } from './components/alerts/alerts.component';
import { LogoutComponent } from './components/logout/logout.component';
import { IncompletePipe } from './pipes/incomplete.pipe';

@NgModule({
    declarations: [
        AppComponent,
        HomeComponent,
        NotfoundComponent,
        NavbarComponent,
        FooterComponent,
        LoginComponent,
        AccountComponent,
        MygroupsComponent,
        AlertsComponent,
        LogoutComponent,
        IncompletePipe
    ],
    providers: [],
    bootstrap: [AppComponent],
    imports: [
        BrowserModule,
        AppRoutingModule,
        FormsModule,
        HttpClientModule,
        NgbModule,

    ]
})
export class AppModule { }
