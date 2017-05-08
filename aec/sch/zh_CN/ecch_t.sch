/* 
================================================================================
檔案代號:ecch_t
檔案名稱:料件製程變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table ecch_t
(
ecchent       number(5)      ,/* 企業代碼 */
ecchsite       varchar2(10)      ,/* 營運據點 */
ecchdocno       varchar2(20)      ,/* 單號 */
ecchseq       number(10,0)      ,/* 項次 */
ecchseq1       number(10,0)      ,/* 項序1 */
ecchseq2       number(10,0)      ,/* 項序2 */
ecch001       number(10,0)      ,/* 變更序 */
ecch002       varchar2(20)      ,/* 變更欄位 */
ecch003       varchar2(10)      ,/* 變更類型 */
ecch004       varchar2(255)      ,/* 變更前內容 */
ecch005       varchar2(255)      ,/* 變更后內容 */
ecch006       varchar2(80)      ,/* 最後變更時間 */
ecch007       varchar2(500)      ,/* 欄位說明SQL */
ecch008       varchar2(40)      ,/* 料件編號 */
ecch009       varchar2(10)      ,/* 製程編號 */
ecchownid       varchar2(20)      ,/* 資料所有者 */
ecchowndp       varchar2(10)      ,/* 資料所屬部門 */
ecchcrtid       varchar2(20)      ,/* 資料建立者 */
ecchcrtdp       varchar2(10)      ,/* 資料建立部門 */
ecchcrtdt       timestamp(0)      ,/* 資料創建日 */
ecchmodid       varchar2(20)      ,/* 資料修改者 */
ecchmoddt       timestamp(0)      ,/* 最近修改日 */
ecchcnfid       varchar2(20)      ,/* 資料確認者 */
ecchcnfdt       timestamp(0)      ,/* 資料確認日 */
ecchpstid       varchar2(20)      ,/* 資料過帳者 */
ecchpstdt       timestamp(0)      ,/* 資料過帳日 */
ecchstus       varchar2(10)      ,/* 狀態碼 */
ecchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecchud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecch_t add constraint ecch_pk primary key (ecchent,ecchsite,ecchdocno,ecchseq,ecchseq1,ecchseq2,ecch002) enable validate;

create unique index ecch_pk on ecch_t (ecchent,ecchsite,ecchdocno,ecchseq,ecchseq1,ecchseq2,ecch002);

grant select on ecch_t to tiptop;
grant update on ecch_t to tiptop;
grant delete on ecch_t to tiptop;
grant insert on ecch_t to tiptop;

exit;
