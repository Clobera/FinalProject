import { Pipe, PipeTransform } from '@angular/core';
import { Address } from '../models/address';

@Pipe({
  name: 'city'
})
export class CityPipe implements PipeTransform {

  transform(addrs : Address[]): string [] {
    let ans : string[] = [];
    for (let addr of addrs){
      if (!ans.includes(addr.city)){
        ans.push(addr.city);
      }
    }
    return ans;
  }

}
