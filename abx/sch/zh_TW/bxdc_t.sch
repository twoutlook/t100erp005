/* 
================================================================================
檔案代號:bxdc_t
檔案名稱:保稅機器設備單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxdc_t
(
bxdcent       number(5)      ,/* 企業編號 */
bxdcsite       varchar2(10)      ,/* 營運據點 */
bxdc001       varchar2(20)      ,/* 機器設備編號 */
bxdc002       number(10,0)      ,/* 序號 */
bxdc003       varchar2(10)      ,/* 保管部門 */
bxdc004       varchar2(20)      ,/* 保管人員 */
bxdc005       number(20,6)      ,/* 數量 */
bxdc006       varchar2(80)      ,/* 放置地點 */
bxdc007       number(20,6)      ,/* 帳面結餘數量 */
bxdc010       number(20,6)      ,/* 外送數量 */
bxdc011       number(20,6)      ,/* 收回數量 */
bxdc012       number(20,6)      ,/* 報廢數量 */
bxdc013       number(20,6)      ,/* 除帳數量 */
bxdc014       varchar2(80)      ,/* 備註 */
bxdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdc_t add constraint bxdc_pk primary key (bxdcent,bxdcsite,bxdc001,bxdc002) enable validate;

create unique index bxdc_pk on bxdc_t (bxdcent,bxdcsite,bxdc001,bxdc002);

grant select on bxdc_t to tiptop;
grant update on bxdc_t to tiptop;
grant delete on bxdc_t to tiptop;
grant insert on bxdc_t to tiptop;

exit;
