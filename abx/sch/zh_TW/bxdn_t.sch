/* 
================================================================================
檔案代號:bxdn_t
檔案名稱:保稅機器設備異動資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxdn_t
(
bxdnent       number(5)      ,/* 企業編號 */
bxdnsite       varchar2(10)      ,/* 營運據點 */
bxdn001       varchar2(20)      ,/* 單據單號 */
bxdn002       number(10,0)      ,/* 單據項次 */
bxdn003       date      ,/* 異動日期 */
bxdn004       varchar2(10)      ,/* 性質 */
bxdn005       number(5,0)      ,/* 狀態 */
bxdn006       varchar2(20)      ,/* 機器裝置編號 */
bxdn007       number(10,0)      ,/* 序號 */
bxdn008       number(20,6)      ,/* 異動數量 */
bxdnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdn_t add constraint bxdn_pk primary key (bxdnent,bxdnsite,bxdn001,bxdn002) enable validate;

create unique index bxdn_pk on bxdn_t (bxdnent,bxdnsite,bxdn001,bxdn002);

grant select on bxdn_t to tiptop;
grant update on bxdn_t to tiptop;
grant delete on bxdn_t to tiptop;
grant insert on bxdn_t to tiptop;

exit;
