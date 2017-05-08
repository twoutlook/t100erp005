/* 
================================================================================
檔案代號:sfla_t
檔案名稱:工單挪料記錄單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfla_t
(
sflaent       number(5)      ,/* 企業編號 */
sflasite       varchar2(10)      ,/* 營運據點 */
sfladocno       varchar2(20)      ,/* 挪料序號 */
sfladocdt       date      ,/* 挪料日期 */
sfla001       varchar2(1)      ,/* 挪料類型 */
sfla002       varchar2(20)      ,/* 申請人 */
sfla003       varchar2(20)      ,/* 發料單號 */
sfla004       varchar2(20)      ,/* 退料單號 */
sflaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sflaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sflaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sflaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sflaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sflaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sflaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sflaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sflaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sflaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sflaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sflaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sflaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sflaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sflaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sflaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sflaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sflaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sflaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sflaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sflaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sflaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sflaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sflaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sflaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sflaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sflaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sflaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sflaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sflaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfla_t add constraint sfla_pk primary key (sflaent,sflasite,sfladocno) enable validate;

create unique index sfla_pk on sfla_t (sflaent,sflasite,sfladocno);

grant select on sfla_t to tiptop;
grant update on sfla_t to tiptop;
grant delete on sfla_t to tiptop;
grant insert on sfla_t to tiptop;

exit;
