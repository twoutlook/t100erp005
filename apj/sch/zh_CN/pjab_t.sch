/* 
================================================================================
檔案代號:pjab_t
檔案名稱:專案立項檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjab_t
(
pjabent       number(5)      ,/* 企業編號 */
pjab001       varchar2(20)      ,/* 專案編號 */
pjab002       date      ,/* 申請日期 */
pjab003       varchar2(10)      ,/* 負責部門 */
pjab004       varchar2(20)      ,/* 專案負責人 */
pjab005       varchar2(500)      ,/* 內容說明 */
pjabownid       varchar2(20)      ,/* 資料所有者 */
pjabowndp       varchar2(10)      ,/* 資料所屬部門 */
pjabcrtid       varchar2(20)      ,/* 資料建立者 */
pjabcrtdp       varchar2(10)      ,/* 資料建立部門 */
pjabcrtdt       timestamp(0)      ,/* 資料創建日 */
pjabmodid       varchar2(20)      ,/* 資料修改者 */
pjabmoddt       timestamp(0)      ,/* 最近修改日 */
pjabcnfid       varchar2(20)      ,/* 資料確認者 */
pjabcnfdt       timestamp(0)      ,/* 資料確認日 */
pjabstus       varchar2(10)      ,/* 狀態碼 */
pjabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjabud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjab006       varchar2(10)      /* 專案類型 */
);
alter table pjab_t add constraint pjab_pk primary key (pjabent,pjab001) enable validate;

create unique index pjab_pk on pjab_t (pjabent,pjab001);

grant select on pjab_t to tiptop;
grant update on pjab_t to tiptop;
grant delete on pjab_t to tiptop;
grant insert on pjab_t to tiptop;

exit;
