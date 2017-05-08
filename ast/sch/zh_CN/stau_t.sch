/* 
================================================================================
檔案代號:stau_t
檔案名稱:結算會計期維護資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stau_t
(
stauent       number(5)      ,/* 企業編號 */
stausite       varchar2(10)      ,/* 營運據點 */
stau001       varchar2(20)      ,/* 程序編碼 */
stau002       varchar2(10)      ,/* 關帳類型 */
stau003       date      ,/* 關帳日期 */
stau004       number(10,0)      ,/* 當前結算會計期 */
stauownid       varchar2(20)      ,/* 資料所有者 */
stauowndp       varchar2(10)      ,/* 資料所屬部門 */
staucrtid       varchar2(20)      ,/* 資料建立者 */
staucrtdp       varchar2(10)      ,/* 資料建立部門 */
staucrtdt       timestamp(0)      ,/* 資料創建日 */
staumodid       varchar2(20)      ,/* 資料修改者 */
staumoddt       timestamp(0)      ,/* 最近修改日 */
stauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stauud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stau_t add constraint stau_pk primary key (stauent,stausite,stau001) enable validate;

create unique index stau_pk on stau_t (stauent,stausite,stau001);

grant select on stau_t to tiptop;
grant update on stau_t to tiptop;
grant delete on stau_t to tiptop;
grant insert on stau_t to tiptop;

exit;
