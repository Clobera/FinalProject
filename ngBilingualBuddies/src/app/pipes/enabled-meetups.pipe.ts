import { Pipe, PipeTransform } from '@angular/core';
import { Meetup } from '../models/meetup';

@Pipe({
  name: 'enabledMeetups'
})
export class EnabledMeetupsPipe implements PipeTransform {

  transform(meetups: Meetup[]): Meetup [] {
    let ans : Meetup []= [];

    for ( let meetup of meetups){
      if (meetup.enabled){
        ans.push(meetup);
      }
    }
    return ans;
  }

}
