/* 
================================================================================
檔案代號:rteg_t
檔案名稱:專櫃新商品引進-商品明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rteg_t
(
rtegent       number(5)      ,/* 企業編號 */
rtegsite       varchar2(10)      ,/* 營運據點 */
rtegunit       varchar2(10)      ,/* 應用組織 */
rtegdocno       varchar2(20)      ,/* 單據編號 */
rtegseq       number(10,0)      ,/* 項次 */
rteg001       varchar2(40)      ,/* 商品編號 */
rteg002       varchar2(40)      ,/* 商品主條碼 */
rteg003       varchar2(80)      ,/* 產地 */
rteg004       varchar2(10)      ,/* 銷售單位 */
rteg005       number(20,6)      ,/* 售價 */
rteg006       varchar2(10)      ,/* 經營方式 */
rteg007       varchar2(255)      ,/* 備註 */
rteg008       varchar2(10)      ,/* 版本 */
rtegacti       varchar2(1)      ,/* 有效 */
rtegud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtegud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtegud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtegud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtegud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtegud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtegud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtegud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtegud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtegud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtegud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtegud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtegud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtegud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtegud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtegud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtegud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtegud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtegud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtegud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtegud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtegud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtegud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtegud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtegud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtegud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtegud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtegud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtegud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtegud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rteg_t add constraint rteg_pk primary key (rtegent,rtegdocno,rtegseq) enable validate;

create unique index rteg_pk on rteg_t (rtegent,rtegdocno,rtegseq);

grant select on rteg_t to tiptop;
grant update on rteg_t to tiptop;
grant delete on rteg_t to tiptop;
grant insert on rteg_t to tiptop;

exit;
