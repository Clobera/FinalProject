import { Pipe, PipeTransform } from '@angular/core';
import { Team } from '../models/team';

@Pipe({
  name: 'teamSearch'
})
export class TeamSearchPipe implements PipeTransform {

  transform(teams : Team[], name : string): Team [] {
    let ans : Team[] = [];
    let name1 : string = name.toUpperCase();
    for (let team of teams){
      if (team.name.toUpperCase().includes(name1) || team.content.toUpperCase().includes(name)){
        ans.push(team);
      }
    }

    return ans;
  }

}
