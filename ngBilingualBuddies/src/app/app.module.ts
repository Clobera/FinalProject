import { UserPostComponent } from './components/user-post/user-post.component';
import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { RegisterComponent } from './components/register/register.component';

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
import { SearchComponent } from './components/search/search.component';
import { SeenPipe } from './pipes/seen.pipe';
import { EnabledUsersPipe } from './pipes/enabled-users.pipe';
import { UserLanguagePipe } from './pipes/user-language.pipe';
import { UserSponsorPipe } from './pipes/user-sponsor.pipe';
import { NameSearchPipe } from './pipes/name-search.pipe';
import { CityPipe } from './pipes/city.pipe';
import { NewsfeedComponent } from './components/newsfeed/newsfeed.component';
import { TeamPipe } from './pipes/team.pipe';
import { UserInCityPipe } from './pipes/user-in-city.pipe';
import { OtherUserComponent } from './components/other-user/other-user.component';
import { TeamComponent } from './components/team/team.component';
import { MeetupComponent } from './components/meetup/meetup.component';
import { CommentComponent } from './components/comment/comment.component';
import { TeamsearchComponent } from './components/teamsearch/teamsearch.component';
import { LinksComponent } from './components/links/links.component';
import { TeamSearchPipe } from './pipes/team-search.pipe';
import { EnabledTeamsPipe } from './pipes/enabled-teams.pipe';
import { MeetupSearchPipe } from './pipes/meetup-search.pipe';
import { EnabledMeetupsPipe } from './pipes/enabled-meetups.pipe';
import { MeetupInCityPipe } from './pipes/meetup-in-city.pipe';


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
        UserPostComponent,
        LogoutComponent,
        IncompletePipe,
        RegisterComponent,
        SearchComponent,
        SeenPipe,
        EnabledUsersPipe,
        UserLanguagePipe,
        UserSponsorPipe,
        NameSearchPipe,
        CityPipe,
        NewsfeedComponent,
        TeamPipe,
        UserInCityPipe,
        OtherUserComponent,
        TeamComponent,
        CommentComponent,
        MeetupComponent,
        TeamsearchComponent,
        LinksComponent,
        TeamSearchPipe,
        EnabledTeamsPipe,
        MeetupSearchPipe,
        EnabledMeetupsPipe,
        MeetupInCityPipe,
    ],
    providers: [
      SeenPipe,
      EnabledUsersPipe,
      UserLanguagePipe,
      MeetupSearchPipe,
      EnabledMeetupsPipe,
      UserSponsorPipe,
      NameSearchPipe,
      TeamSearchPipe,
      EnabledTeamsPipe,
      CityPipe,
      TeamPipe,
      UserInCityPipe,
      MeetupInCityPipe
    ],
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
