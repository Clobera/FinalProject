import { Pipe, PipeTransform } from '@angular/core';
import { User } from '../models/user';

@Pipe({
  name: 'enabledUsers'
})
export class EnabledUsersPipe implements PipeTransform {

  transform(users: User[]): User [] {
    let ans : User []= [];

    for ( let user of users){
      if (user.enabled){
        ans.push(user);
      }
    }
    return ans;
  }

}
