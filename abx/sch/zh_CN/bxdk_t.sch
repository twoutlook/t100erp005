/* 
================================================================================
檔案代號:bxdk_t
檔案名稱:保稅機器設備收回單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxdk_t
(
bxdkent       number(5)      ,/* 企業編號 */
bxdksite       varchar2(10)      ,/* 營運據點 */
bxdkdocno       varchar2(20)      ,/* 收回單號 */
bxdkseq       number(10,0)      ,/* 項次 */
bxdk001       varchar2(20)      ,/* 外送單號 */
bxdk002       number(10,0)      ,/* 外送項次 */
bxdk003       number(20,6)      ,/* 本次收回數量 */
bxdk004       varchar2(255)      ,/* 備註 */
bxdkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdk_t add constraint bxdk_pk primary key (bxdkent,bxdkdocno,bxdkseq) enable validate;

create unique index bxdk_pk on bxdk_t (bxdkent,bxdkdocno,bxdkseq);

grant select on bxdk_t to tiptop;
grant update on bxdk_t to tiptop;
grant delete on bxdk_t to tiptop;
grant insert on bxdk_t to tiptop;

exit;
