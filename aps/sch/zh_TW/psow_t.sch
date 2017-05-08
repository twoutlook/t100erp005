/* 
================================================================================
檔案代號:psow_t
檔案名稱:工單製程內容檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psow_t
(
psowent       number(5)      ,/* 企業編號 */
psowsite       varchar2(10)      ,/* 營運據點 */
psow001       varchar2(10)      ,/* APS版本 */
psow002       varchar2(20)      ,/* 執行日期時間 */
psow003       varchar2(40)      ,/* 工單編號 */
psow004       varchar2(80)      ,/* 途程編號 */
psow005       varchar2(10)      ,/* 加工序號 */
psow006       varchar2(10)      ,/* 作業編號 */
psow007       number(5,0)      ,/* 外包 */
psow008       number(5,0)      ,/* 資源型態 */
psow009       varchar2(20)      ,/* 資源編號 */
psow010       number(10,0)      ,/* 排程順序 */
psow011       number(20,6)      ,/* 製造數量 */
psow012       date      ,/* 開始時間 */
psow013       date      ,/* 完成時間 */
psow014       varchar2(10)      ,/* 工作中心編號 */
psow015       varchar2(10)      ,/* 資源群組編號 */
psow016       date      ,/* 最早可開工日 */
psow017       date      ,/* 最晚需完工時間 */
psow018       number(5,0)      ,/* 平行資源任務 */
psow019       number(5,0)      ,/* 連批 */
psow020       number(15,3)      ,/* 壓縮時間 */
psow021       number(20,6)      ,/* 產能重疊比例 */
psow022       number(5,0)      ,/* 超出排程邊界 */
psow023       date      ,/* 整備開始時間 */
psow024       date      ,/* 整備結束時間 */
psow025       date      ,/* 加工開始時間 */
psow026       date      ,/* 加工結束時間 */
psow027       number(10,0)      ,/* 整備製造週期 */
psow028       number(10,0)      ,/* 加工製造週期 */
psow029       date      ,/* 前置開始時間 */
psow030       date      ,/* 前置結束時間 */
psow031       date      ,/* 後置開始時間 */
psow032       date      ,/* 後置結束時間 */
psow033       number(10,0)      ,/* 前置週期時間 */
psow034       number(10,0)      ,/* 後置週期時間 */
psow035       number(10,0)      ,/* queue_time */
psow036       varchar2(40)      ,/* skl_phase */
psow037       date      ,/* skl_time */
psow038       number(10,0)      ,/* pre_op_lead_time */
psow039       number(10,0)      /* post_op_lead_time */
);
alter table psow_t add constraint psow_pk primary key (psowent,psowsite,psow001,psow002,psow010) enable validate;

create unique index psow_pk on psow_t (psowent,psowsite,psow001,psow002,psow010);

grant select on psow_t to tiptop;
grant update on psow_t to tiptop;
grant delete on psow_t to tiptop;
grant insert on psow_t to tiptop;

exit;
