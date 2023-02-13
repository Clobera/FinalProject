import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Team } from 'src/app/models/team';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { TeamService } from 'src/app/services/team.service';

@Component({
  selector: 'app-team',
  templateUrl: './team.component.html',
  styleUrls: ['./team.component.css']
})
export class TeamComponent {

  team = new Team();
  editTeam: Team | null = null;
  teams: Team[] = [];
  newTeam: Team = new Team();
  user = new User();
  owner = new User();
  showForm: boolean = false;
  myTeam: Team | null = null;

  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private teamService: TeamService
  ){}

  // checkUserTeam(){
  //   if(this.team.owner.id === this.user.id){
  //     this.showForm = false;
  //   }

  // }

  ngOnInit() : void{
    this.loadUser();
  }

  loadUser(){
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
        this.teamService.showByUsername(data.username).subscribe({
          next: (result) =>{
            this.myTeam = result;
          },
          error: (ugh) =>{
            console.log(
              'NavbarCompenent.loadUser: Error getting user'
            );
            console.log(ugh);
            this.myTeam = null;
          }
        });
      },
      error: (err) => {
        console.log(
          'NavbarCompenent.loadUser: Error getting user'
        );
        console.log(err);
      }
    });
  }

  create(team: Team)  {
    team.owner = this.user;
    this.teamService.create(team).subscribe({
      next: (result) =>{
        this.newTeam = new Team();
      },
      error: (error) =>{
        console.error("Error creating team");
        console.error(error);
      }
    });
  }


  updateTeam(team: Team){
    this.teamService.update(team).subscribe({
      next: () => {
        this.reload();
      },
      error: (fail) => {
        console.error(' Error deleting team');
        console.error(fail);
      },
    });
  }




  deleteTeam(id: number){
    this.teamService.destroy(id).subscribe({
      next: () => {
        this.reload();
      },
      error: (fail) => {
        console.error(' Error deleting team');
        console.error(fail);
      },
    });
  }


  reload(){
    this.teamService.index().subscribe({
      next: (teamss) =>{
        this.teams = teamss;
      },
      error:(oops) => {
        console.error("Error retrieving teams");
        console.error(oops);
      }
    });
  }



  styleUserTeams(){
    let num = this.getNumberOfTeams();
    if(num > 10){
      return 'bg-success';
    } else if( num >= 5){
      return 'bg-warning';
    } else {
      return 'bg-danger';
    }
  }

  getNumberOfTeams(){
    return this.teams.length;
  }

}
