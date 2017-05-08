/* 
================================================================================
檔案代號:fmmh_t
檔案名稱:延長平倉期限記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmmh_t
(
fmmhent       number(5)      ,/* 企業代碼 */
fmmh001       varchar2(20)      ,/* 投資審核單號 */
fmmh002       date      ,/* 原始平倉日期 */
fmmh003       date      ,/* 更新平倉日期 */
fmmhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmhud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmh004       date      /* 異動日期 */
);
alter table fmmh_t add constraint fmmh_pk primary key (fmmhent,fmmh001,fmmh002,fmmh003) enable validate;

create unique index fmmh_pk on fmmh_t (fmmhent,fmmh001,fmmh002,fmmh003);

grant select on fmmh_t to tiptop;
grant update on fmmh_t to tiptop;
grant delete on fmmh_t to tiptop;
grant insert on fmmh_t to tiptop;

exit;
