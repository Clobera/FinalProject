import { IncompletePipe } from './incomplete.pipe';

describe('IncompletePipe', () => {
  it('create an instance', () => {
    const pipe = new IncompletePipe();
    expect(pipe).toBeTruthy();
  });
});
