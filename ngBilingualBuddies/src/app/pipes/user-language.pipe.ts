import { User } from 'src/app/models/user';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'userLanguage'
})
export class UserLanguagePipe implements PipeTransform {

  transform(users: User [], lang : string): User [] {
    let ans : User [] = [];
    for (let user of users){
      for ( let language of user.languages){
        if (language.id === parseInt(lang)){
          ans.push(user);
          break;
        }
      }
    }
    return ans;
  }

}
