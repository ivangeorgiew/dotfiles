Vim�UnDo� ��>	_�%1�V�U��ZEOgv�'�P�W=�   *   "export const undoable => reducer {            *       *   *   *    Y��    _�                             ����                                                                                                                                                                                                                                                                                                                                                             Y��Z     �                   �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Y��e     �          ,      function undoable(reducer) {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             Y��h     �          ,      const  undoable(reducer) {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             Y��l     �          ,      const undoable(reducer) {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             Y��m     �          ,      const undoable => (reducer) {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             Y��n     �          ,      const undoable => reducer) {5�_�                    
   	    ����                                                                                                                                                                                                                                                                                                                            
   	       
          v       Y��t     �   	      ,      2  return function (state = initialState, action) {5�_�      	              
   
    ����                                                                                                                                                                                                                                                                                                                            
   	       
          v       Y��u     �   	      ,      ,  return () (state = initialState, action) {5�_�      
           	   
   
    ����                                                                                                                                                                                                                                                                                                                            
   	       
          v       Y��u     �   	      ,      +  return ( (state = initialState, action) {5�_�   	              
   
   	    ����                                                                                                                                                                                                                                                                                                                            
   	       
          v       Y��v     �   	      ,      *  return ((state = initialState, action) {5�_�   
                 
   (    ����                                                                                                                                                                                                                                                                                                                            
   	       
          v       Y��x     �   	      ,      )  return (state = initialState, action) {5�_�                    
       ����                                                                                                                                                                                                                                                                                                                            
   	       
          v       Y��z     �   	      ,      .    return (state = initialState, action) => {5�_�                            ����                                                                                                                                                                                                                                                                                                                            
   	       
          v       Y��}     �   )   +            }�   (   *              }�   '   )          	        }�   &   (                    future: []�   %   '                    present: newPresent,�   $   &          #          past: [...past, present],�   #   %                  return {�   "   $          	        }�   !   #                    return state�       "          %        if (present === newPresent) {�      !          3        const newPresent = reducer(present, action)�                 =        // Delegate handling the action to the passed reducer�                      default:�                	        }�                          future: newFuture�                          present: next,�                #          past: [...past, present],�                        return {�                )        const newFuture = future.slice(1)�                        const next = future[0]�                      case 'REDO':�                	        }�                &          future: [present, ...future]�                          present: previous,�                          past: newPast,�                        return {�                6        const newPast = past.slice(0, past.length - 1)�                .        const previous = past[past.length - 1]�                      case 'UNDO':�                    switch (action.type) {�   
             +    const { past, present, future } = state�   	             *return (state = initialState, action) => {�      
          0  // Return a reducer that handles undo and redo�                  }�                    future: []�                $    present: reducer(undefined, {}),�                    past: [],�                  const initialState = {�                E  // Call the reducer with empty action to populate the initial state5�_�                       !    ����                                                                                                                                                                                                                                                                                                                               !          5       v   5    Y��     �         ,      6                const previous = past[past.length - 1]5�_�                           ����                                                                                                                                                                                                                                                                                                                                         $       v   $    Y��     �         ,      &                    present: previous,�         ,    5�_�                            ����                                                                                                                                                                                                                                                                                                                                          =       v   =    Y��     �         ,      >                const newPast = past.slice(0, past.length - 1)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                 v        Y��     �         ,      "                    past: newPast,�         ,    5�_�                       !    ����                                                                                                                                                                                                                                                                                                                                         !       V   7    Y��     �                !                const previous =                     const newPast = 5�_�                           ����                                                                                                                                                                                                                                                                                                                                                 v        Y��     �         *      "                    present: next,�         *    5�_�                           ����                                                                                                                                                                                                                                                                                                                                         $       v   $    Y��     �         *      %                    future: newFuture�         *    5�_�                       &    ����                                                                                                                                                                                                                                                                                                                               *          &       V   *    Y��     �                &                const next = future[0]   1                const newFuture = future.slice(1)5�_�                            ����                                                                                                                                                                                                                                                                                                                               *          &       V   *    Y���    �          (      const undoable => reducer {5�_�                            ����                                                                                                                                                                                                                                                                                                                               *          &       V   *    Y��;     �          )       �          (    5�_�                           ����                                                                                                                                                                                                                                                                                                                               *          &       V   *    Y��A     �          )      import { map 5�_�                           ����                                                                                                                                                                                                                                                                                                                               *          &       V   *    Y��B     �         )    5�_�                            ����                                                                                                                                                                                                                                                                                                                               	          	       V   	    Y��Y     �          )    �         )    �                 import { map }5�_�                          ����                                                                                                                                                                                                                                                                                                                                                v       Y��o     �         *                      return {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       Y��r     �         *                      }5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       Y��v     �         *                      return {5�_�                            ����                                                                                                                                                                                                                                                                                                                                                v       Y��x     �         *                      }5�_�      !               "       ����                                                                                                                                                                                                                                                                                                                                                v       Y��|     �   !   #   *                      return {5�_�       "           !   &       ����                                                                                                                                                                                                                                                                                                                                                v       Y��    �   %   '   *                      }5�_�   !   #           "          ����                                                                                                                                                                                                                                                                                                                                                v       Y���     �         *                      return Map({5�_�   "   $           #          ����                                                                                                                                                                                                                                                                                                                                                v       Y���     �         *                      return Map({5�_�   #   %           $           ����                                                                                                                                                                                                                                                                                                                                                v       Y���     �                 *import { Map, List, Set } from 'immutable'5�_�   $   &           %   "        ����                                                                                                                                                                                                                                                                                                                                                v       Y���     �   !   #                          return Map({5�_�   %   '           &          ����                                                                                                                                                                                                                                                                                                                                                v       Y���    �          *      -import { fromJS, List, Set } from 'immutable'5�_�   &   (           '          ����                                                                                                                                                                                                                                                                                                                                                v       Y���     �         *          const initialState = {5�_�   '   )           (   	       ����                                                                                                                                                                                                                                                                                                                                                v       Y��    �      
   *          }5�_�   (   *           )          ����                                                                                                                                                                                                                                                                                                                                                v       Y��     �         *      "export const undoable => reducer {5�_�   )               *           ����                                                                                                                                                                                                                                                                                                                                                v       Y��    �         *      !export const undoable = reducer {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       Y��^     �          *      import { Map } from 'immutable'5��