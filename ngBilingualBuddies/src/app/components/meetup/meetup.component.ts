import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Meetup } from 'src/app/models/meetup';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { MeetupService } from 'src/app/services/meetup.service';

@Component({
  selector: 'app-meetup',
  templateUrl: './meetup.component.html',
  styleUrls: ['./meetup.component.css']
})
export class MeetupComponent {
  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private meetupService: MeetupService
  ){}


  meetup = new Meetup();
  editMeetup: Meetup | null = null;
  meetups: Meetup[] = [];
  newMeetup: Meetup = new Meetup();
  user = new User();

  ngOnInit(): void{
    this.loadUser();
  }
  loadUser(){
    this.auth.getLoggedInUser().subscribe({
    next: (data) => {
      this.user = data;
    },
    error: (err) => {
      console.log(
        'NavbarCompenent.loadUser: Error getting user'
      );
      console.log(err);
    }
  });
  }

  create(meetup: Meetup){
    meetup.owner= this.user
    this.meetupService.create(meetup).subscribe({
      next: (result) =>{
        this.newMeetup = new Meetup();
        this.reload();
      },
      error: (error) =>{
        console.error("Error creating Meetup");
        console.error(error);
      }
    });
  }

  deletePost(name: string, meetup: Meetup){
    if(meetup.owner === this.user){
  this.meetupService.destroy(meetup, name).subscribe({
    next: () => {
      this.reload();
    },
    error: (fail) => {
      console.error(' Error deleting Meetup');
      console.error(fail);
    },
  });
}
}

reload(){
  this.meetupService.index().subscribe({
    next: (meetups) =>{
      this.meetups = meetups;
    },
    error:(oops) => {
      console.error("Error retrieving meetups");
      console.error(oops);
    }
  });
}
styleUserMeetups(){
  let num = this.getNumberOfMeetups();
  if(num > 10){
    return 'bg-success';
  } else if( num >= 5){
    return 'bg-warning';
  } else {
    return 'bg-danger';
  }
}
getNumberOfMeetups(){
  return this.meetups.length;
}

}


