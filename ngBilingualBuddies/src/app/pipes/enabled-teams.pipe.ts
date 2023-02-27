import { Pipe, PipeTransform } from '@angular/core';
import { Team } from '../models/team';

@Pipe({
  name: 'enabledTeams'
})
export class EnabledTeamsPipe implements PipeTransform {

  transform(teams: Team[]): Team [] {
    let ans : Team []= [];

    for ( let team of teams){
      if (team.enabled){
        ans.push(team);
      }
    }
    return ans;
  }

}
