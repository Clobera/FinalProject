import { Pipe, PipeTransform } from '@angular/core';
import { User } from '../models/user';

@Pipe({
  name: 'userInCity'
})
export class UserInCityPipe implements PipeTransform {

  transform(users : User[], city : string): User [] {
    let ans : User[] = [];
    for (let user of users){
      console.log("city in user" + user.address.city);
      console.log("type of city" + typeof user.address.city);
      if (user.address.city === city){

        ans.push(user);
      }
    }
    return ans;
  }

}
