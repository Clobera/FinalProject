import { User } from 'src/app/models/user';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'nameSearch'
})
export class NameSearchPipe implements PipeTransform {

  transform(users : User[], name : string): User [] {
let ans : User[] = [];
    for (let user of users){
      if (user.firstName.toUpperCase().includes(name.toUpperCase()) || user.lastName.toUpperCase().includes(name.toUpperCase()) || user.username.toUpperCase().includes(name.toUpperCase())){
        ans.push(user);
      }
    }

    return ans;
  }

}
