import { User } from 'src/app/models/user';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'nameSearch'
})
export class NameSearchPipe implements PipeTransform {

  transform(users : User[], name : string): User [] {
let ans : User[] = [];
    for (let user of users){
      if (user.firstName.includes(name) || user.lastName.includes(name) || user.username.includes(name)){
        ans.push(user);
      }
    }

    return ans;
  }

}
