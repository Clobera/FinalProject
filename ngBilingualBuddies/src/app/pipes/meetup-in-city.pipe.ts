import { Pipe, PipeTransform } from '@angular/core';
import { Meetup } from '../models/meetup';

@Pipe({
  name: 'meetupInCity'
})
export class MeetupInCityPipe implements PipeTransform {

  transform(meetups : Meetup[], city : string): Meetup [] {
    let ans : Meetup[] = [];
    for (let meetup of meetups){
      console.log("city in meetup" + meetup.address.city);
      console.log("type of meetup" + typeof meetup.address.city);
      if (meetup.address.city === city){

        ans.push(meetup);
      }
    }
    return ans;
  }

}
