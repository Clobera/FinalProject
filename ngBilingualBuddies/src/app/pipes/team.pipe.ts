import { Team } from './../models/team';
import { Pipe, PipeTransform } from '@angular/core';
import { User } from '../models/user';

@Pipe({
  name: 'team'
})
export class TeamPipe implements PipeTransform {

  transform(teams : Team[], user : User): Team[] {
    let ans : Team[] = [];
    for ( let team of teams){
      if (team.members === undefined){
        continue;
      }
      for (let member of team.members){
        if (member.id === user.id){
          ans.push(team);
        }
      }
    }
    return ans;
  }

}
