/* 
================================================================================
檔案代號:ecab_t
檔案名稱:製程作業預設Check in/Check out項目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ecab_t
(
ecabent       number(5)      ,/* 企業編號 */
ecabownid       varchar2(20)      ,/* 資料所有者 */
ecabowndp       varchar2(10)      ,/* 資料所屬部門 */
ecabcrtid       varchar2(20)      ,/* 資料建立者 */
ecabcrtdp       varchar2(10)      ,/* 資料建立部門 */
ecabcrtdt       timestamp(0)      ,/* 資料創建日 */
ecabmodid       varchar2(20)      ,/* 資料修改者 */
ecabmoddt       timestamp(0)      ,/* 最近修改日 */
ecabstus       varchar2(10)      ,/* 狀態碼 */
ecab001       varchar2(10)      ,/* 作業編號 */
ecabseq       number(10,0)      ,/* 項序 */
ecab002       varchar2(1)      ,/* check in/check out */
ecab003       varchar2(10)      ,/* 項目 */
ecab004       varchar2(10)      ,/* 形態 */
ecab005       number(15,3)      ,/* 下限 */
ecab006       number(15,3)      ,/* 上限 */
ecab007       varchar2(80)      ,/* 預設值 */
ecab008       varchar2(1)      ,/* 必要 */
ecabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecab_t add constraint ecab_pk primary key (ecabent,ecab001,ecabseq) enable validate;

create unique index ecab_pk on ecab_t (ecabent,ecab001,ecabseq);

grant select on ecab_t to tiptop;
grant update on ecab_t to tiptop;
grant delete on ecab_t to tiptop;
grant insert on ecab_t to tiptop;

exit;
