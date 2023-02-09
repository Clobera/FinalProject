import { Pipe, PipeTransform } from '@angular/core';
import { Alert } from '../models/alert';

@Pipe({
  name: 'seen'
})
export class SeenPipe implements PipeTransform {

  transform(alerts : Alert[]):Alert[] {
    console.log(alerts);

    let ans : Alert[] = [];
    for (let al of alerts){
      if (al.seen){
        ans.push(al);
      }
    }
    console.log(ans);
    return ans;
  }

}
