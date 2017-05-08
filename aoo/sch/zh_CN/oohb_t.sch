/* 
================================================================================
檔案代號:oohb_t
檔案名稱:控制組部門檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohb_t
(
oohbent       number(5)      ,/* 企業編號 */
oohb001       varchar2(10)      ,/* 控制組編號 */
oohb002       varchar2(10)      ,/* 部門編號 */
oohb003       date      ,/* 生效日期 */
oohb004       date      ,/* 失效日期 */
oohbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohb_t add constraint oohb_pk primary key (oohbent,oohb001,oohb002) enable validate;

create  index oohb_01 on oohb_t (oohb003);
create  index oohb_02 on oohb_t (oohb004);
create unique index oohb_pk on oohb_t (oohbent,oohb001,oohb002);

grant select on oohb_t to tiptop;
grant update on oohb_t to tiptop;
grant delete on oohb_t to tiptop;
grant insert on oohb_t to tiptop;

exit;
