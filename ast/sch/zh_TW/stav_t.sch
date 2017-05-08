/* 
================================================================================
檔案代號:stav_t
檔案名稱:結算會計期維護資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stav_t
(
stavent       number(5)      ,/* 企業編號 */
stav001       varchar2(20)      ,/* 程式編號 */
stav002       varchar2(10)      ,/* 費用編號 */
stavownid       varchar2(20)      ,/* 資料所有者 */
stavowndp       varchar2(10)      ,/* 資料所屬部門 */
stavcrtid       varchar2(20)      ,/* 資料建立者 */
stavcrtdp       varchar2(10)      ,/* 資料建立部門 */
stavcrtdt       timestamp(0)      ,/* 資料創建日 */
stavmodid       varchar2(20)      ,/* 資料修改者 */
stavmoddt       timestamp(0)      ,/* 最近修改日 */
stavud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stavud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stavud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stavud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stavud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stavud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stavud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stavud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stavud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stavud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stavud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stavud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stavud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stavud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stavud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stavud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stavud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stavud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stavud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stavud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stavud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stavud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stavud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stavud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stavud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stavud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stavud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stavud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stavud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stavud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stav_t add constraint stav_pk primary key (stavent,stav001) enable validate;

create unique index stav_pk on stav_t (stavent,stav001);

grant select on stav_t to tiptop;
grant update on stav_t to tiptop;
grant delete on stav_t to tiptop;
grant insert on stav_t to tiptop;

exit;
