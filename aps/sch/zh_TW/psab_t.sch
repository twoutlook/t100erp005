/* 
================================================================================
檔案代號:psab_t
檔案名稱:獨立需求單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psab_t
(
psabent       number(5)      ,/* 企業編號 */
psabsite       varchar2(10)      ,/* 營運據點 */
psabdocno       varchar2(20)      ,/* 需求單號 */
psabseq       number(10,0)      ,/* 項次 */
psab001       varchar2(40)      ,/* 料件編號 */
psab002       varchar2(256)      ,/* 產品特徵 */
psab003       date      ,/* 需求日期 */
psab004       varchar2(10)      ,/* 單位 */
psab005       number(20,6)      ,/* 需求數量 */
psab006       number(20,6)      ,/* 已耗需求 */
psab007       varchar2(255)      ,/* 備註 */
psab008       varchar2(1)      ,/* 結案 */
psab009       varchar2(1)      ,/* MRP凍結 */
psabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psabud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
psab010       varchar2(20)      ,/* 專案編號 */
psab011       varchar2(30)      ,/* WBS編號 */
psab012       varchar2(30)      ,/* BOM特性 */
psab013       varchar2(1)      /* 保稅否 */
);
alter table psab_t add constraint psab_pk primary key (psabent,psabdocno,psabseq) enable validate;

create unique index psab_pk on psab_t (psabent,psabdocno,psabseq);

grant select on psab_t to tiptop;
grant update on psab_t to tiptop;
grant delete on psab_t to tiptop;
grant insert on psab_t to tiptop;

exit;
