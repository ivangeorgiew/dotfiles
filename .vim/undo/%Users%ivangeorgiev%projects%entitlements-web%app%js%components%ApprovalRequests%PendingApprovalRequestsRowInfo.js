Vim�UnDo� u���.���*�Wj1H;��QB���8Yʐ�      *    onRejectApprReqClick: func.isRequired,      )      .       .   .   .    Y�ec    _�                     	       ����                                                                                                                                                                                                                                                                                                                            	          	   '       v   '    Y�Y�     �      
   7      <export class RoleToEGApprovalRequestsRow extends Component {5�_�                    1        ����                                                                                                                                                                                                                                                                                                                            1           1          v       Y�Y�    �   0   2   7      )RoleToEGApprovalRequestsRow.propTypes = {�   1   2   7    5�_�                           ����                                                                                                                                                                                                                                                                                                                            1           1          v       Y�Y�     �                #        if (isPARequestsSelected) {5�_�                            ����                                                                                                                                                                                                                                                                                                                                      ,   	       V       Y�Y�     �                	        }               return (   2            <div className='my-requests-selected'>   I                <ExpandableRowCell value={apprReq.get(REQUEST_STATUS)} />                   <IconCell                        icon='trash'   \                    onClick={onCancelApprReqPartial({ approvalRequestId: apprReq.get(ID) })}   S                    isDisabled={apprReq.get(REQUEST_STATUS) !== 'PENDING_APPROVAL'}   B                    className='recommended-entitlement-group-icon'   "                    title='cancel'                   />               </div>   	        )5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       Y�Y�     �                            )�                                </div>�                                    />�                &                        title='reject'�                F                        className='recommended-entitlement-group-icon'�                `                        onClick={onRejectApprReqPartial({ approvalRequestId: apprReq.get(ID) })}�                *                        icon='thumbs-down'�                                    <IconCell�                                    />�                '                        title='approve'�                a                        onClick={onApproveApprReqPartial({ approvalRequestId: apprReq.get(ID) })}�                (                        icon='thumbs-up'�                F                        className='recommended-entitlement-group-icon'�                                    <IconCell�                M                    <ExpandableRowCell value={apprReq.get(REQUESTOR_NAME)} />�                ?                <div className='my-pending-approvals-selected'>�                            return (5�_�                           ����                                                                                                                                                                                                                                                                                                                                         %       v   %    Y�Y�     �   
      (      T        const { isPARequestsSelected, apprReq, onCancelApprReqPartial } = this.props5�_�                           ����                                                                                                                                                                                                                                                                                                                                         .       v   .    Y�Y�    �   
      (      >        const { apprReq, onCancelApprReqPartial } = this.props5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                         %       v   %    Y�Y�     �   
      (      &        const { apprReq } = this.props5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                v       Y�Y�     �         (      N        const { onRejectApprReqPartial, onApproveApprReqPartial } = this.props5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                v       Y�Y�    �   
      (              const { apprReq   F        onRejectApprReqPartial, onApproveApprReqPartial } = this.props5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                v       Y�Y�    �   
      '      V        const { apprReq onRejectApprReqPartial, onApproveApprReqPartial } = this.props5�_�                           ����                                                                                                                                                                                                                                                                                                                                         &       v   &    Y�Y�    �         '      Kimport { REQUESTOR_NAME, REQUEST_STATUS } from 'constants/approvalRequests'5�_�                    "       ����                                                                                                                                                                                                                                                                                                                                         &       v   &    Y�Y�     �   !   "          *    isPARequestsSelected: bool.isRequired,5�_�                   %       ����                                                                                                                                                                                                                                                                                                                            $          #          V       Y�Y�     �   $   %          +    onCancelApprReqPartial: func.isRequired5�_�                    $   ,    ����                                                                                                                                                                                                                                                                                                                            $          #          V       Y�Y�    �   #   %   %      -    onApproveApprReqPartial: func.isRequired,5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                         	       v   	    Y�Y�     �         %      'import { bool, func } from 'prop-types'5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                         	       v   	    Y�Y�    �         %      "import {  func } from 'prop-types'5�_�                           ����                                                                                                                                                                                                                                                                                                                               6          C       v   C    Y�d�     �                I                <ExpandableRowCell value={apprReq.get(REQUESTOR_NAME)} />5�_�                    	   $    ����                                                                                                                                                                                                                                                                                                                            	   $       	   *       v   *    Y�d�     �      
   $      ?export class PendingApprovalRequestsRowInfo extends Component {5�_�                             ����                                                                                                                                                                                                                                                                                                                                                   v       Y�d�    �      !   $      ,PendingApprovalRequestsRowInfo.propTypes = {�       !   $    5�_�                           ����                                                                                                                                                                                                                                                                                                                                            #       v       Y�d�     �                ;            <div className='my-pending-approvals-selected'>5�_�                           ����                                                                                                                                                                                                                                                                                                                                          #       v       Y�d�     �         #              return (5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       Y�d�   	 �         $                  </div>5�_�                            ����                                                                                                                                                                                                                                                                                                                                                v       Y�d�     �                ;import { REQUESTOR_NAME } from 'constants/approvalRequests'5�_�                            ����                                                                                                                                                                                                                                                                                                                                                v       Y�d�     �                Bimport { ExpandableRowCell } from 'components/ExpandableRowsTable'5�_�                       -    ����                                                                                                                                                                                                                                                                                                                               -          3       v   3    Y�e     �         "      ]                    onClick={onApproveApprReqPartial({ approvalRequestId: apprReq.get(ID) })}5�_�                       2    ����                                                                                                                                                                                                                                                                                                                               2          Y       v   Y    Y�e     �         "      [                    onClick={onApproveApprReqClick({ approvalRequestId: apprReq.get(ID) })}5�_�                       ,    ����                                                                                                                                                                                                                                                                                                                               ,          Z       v   Z    Y�e   
 �         "      \                    onClick={onRejectApprReqPartial({ approvalRequestId: apprReq.get(ID) })}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  v       Y�e)     �      !   "      ,    onRejectApprReqPartial: func.isRequired,�       !   "    5�_�                     !       ����                                                                                                                                                                                                                                                                                                                            !          !          v       Y�e2    �       "   "      ,    onApproveApprReqPartial: func.isRequired�   !   "   "    5�_�      !               	   (    ����                                                                                                                                                                                                                                                                                                                            	   (       	   .       v   .    Y�e7     �      
   "      W        const { apprReq, onRejectApprReqPartial, onApproveApprReqPartial } = this.props5�_�       "           !   	   ?    ����                                                                                                                                                                                                                                                                                                                            	   ?       	   E       v   E    Y�e;    �      
   "      U        const { apprReq, onRejectApprReqClick, onApproveApprReqPartial } = this.props5�_�   !   #           "           ����                                                                                                                                                                                                                                                                                                                            	   ?       	   E       v   E    Y�e>    �                %import { ID } from 'constants/global'5�_�   "   $           #          ����                                                                                                                                                                                                                                                                                                                                                v       Y�eE    �      	   !      S        const { apprReq, onRejectApprReqClick, onApproveApprReqClick } = this.props5�_�   #   %           $          ����                                                                                                                                                                                                                                                                                                                                                v       Y�eK    �                    apprReq: map.isRequired,5�_�   $   &           %           ����                                                                                                                                                                                                                                                                                                                                                v       Y�eM    �                /import { map } from 'react-immutable-proptypes'5�_�   %   '           &      &    ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�eY     �               J        const { onRejectApprReqClick, onApproveApprReqClick } = this.props5�_�   &   (           '          ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�eZ     �               5        const { onRejectApprReqClick,  } = this.props�             5�_�   '   )           (      %    ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�e[     �               J        const { onApproveApprReqClickonRejectApprReqClick,  } = this.props5�_�   (   *           )      ;    ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�e\     �               L        const { onApproveApprReqClick, onRejectApprReqClick,  } = this.props5�_�   )   +           *      ;    ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�e\    �               K        const { onApproveApprReqClick, onRejectApprReqClick  } = this.props5�_�   *   ,           +           ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�e_     �                *    onApproveApprReqClick: func.isRequired5�_�   +   -           ,           ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�e`     �             �             5�_�   ,   .           -      *    ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�ea     �               *    onApproveApprReqClick: func.isRequired5�_�   -               .      )    ����                                                                                                                                                                                                                                                                                                                               &          :       v   :    Y�eb    �               *    onRejectApprReqClick: func.isRequired,5�_�                    #       ����                                                                                                                                                                                                                                                                                                                            #          #          V       Y�Y�     �   "   %        5��