/* 
================================================================================
檔案代號:bxde_t
檔案名稱:保稅機器設備記帳卡單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxde_t
(
bxdeent       number(5)      ,/* 企業編號 */
bxdesite       varchar2(10)      ,/* 營運據點 */
bxde001       varchar2(10)      ,/* 記帳卡編號 */
bxde002       number(10,0)      ,/* 序號 */
bxde003       varchar2(20)      ,/* 機器設備編號 */
bxde004       varchar2(255)      ,/* 備註 */
bxdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxde_t add constraint bxde_pk primary key (bxdeent,bxdesite,bxde001,bxde002) enable validate;

create unique index bxde_pk on bxde_t (bxdeent,bxdesite,bxde001,bxde002);

grant select on bxde_t to tiptop;
grant update on bxde_t to tiptop;
grant delete on bxde_t to tiptop;
grant insert on bxde_t to tiptop;

exit;
