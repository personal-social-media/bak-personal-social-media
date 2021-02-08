import {useRef} from 'react';
import SearchList from './top-search/list';
import TopSearchInput from './top-search/input';

export default function TopSearch() {
  const inputRef = useRef();

  return (
    <div>
      <TopSearchInput ref={inputRef}/>
      <SearchList inputRef={inputRef}/>
    </div>
  );
}
