import { Pipe, PipeTransform } from '@angular/core';
import { User } from '../models/user';

@Pipe({
  name: 'userSponsor'
})
export class UserSponsorPipe implements PipeTransform {

  transform(users : User []): User [] {
    let ans : User[] = [];

    for (let user of users){
      if (user.sponsor){
        ans.push(user);
      }
    }
    return ans;
  }

}
