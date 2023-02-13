import { UserService } from 'src/app/services/user.service';
import { ActivatedRoute } from '@angular/router';
import { Component } from '@angular/core';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-other-user',
  templateUrl: './other-user.component.html',
  styleUrls: ['./other-user.component.css']
})
export class OtherUserComponent {
constructor(private route : ActivatedRoute, private userService : UserService) {}

username = '';
user = new User();
test = 0;

ngOnInit(){
  this.route.params.subscribe( params => this.username = params['id']);
  console.log(this.username);
  this.loadUser();

}
loadUser(){
  this.userService.show(this.username).subscribe({
    next: (data) => {
      this.user = data;
    },
    error: (err) => {
      console.log(
        'SearchComponent.loadLanguages: Error loading languages ' + err
      );
    }
  })
}


}
