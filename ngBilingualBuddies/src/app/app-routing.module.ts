import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { NotfoundComponent } from './components/notfound/notfound.component';

const routes: Routes = [
  {path: '', redirectTo: 'home', pathMatch: 'full'},
  {path: 'Home', component: HomeComponent},
  {path: 'Account', component: AccountComponent},
  {path: 'MyGroups', component: MyGroupsComponent},
  {path: 'Alerts', component: AlertsComponent},
  {path: 'LogOut', component: LogOutComponent},

  {path: '**', component: NotfoundComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
