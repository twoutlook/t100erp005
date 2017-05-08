/* 
================================================================================
檔案代號:mmay_t
檔案名稱:會員卡領用申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmay_t
(
mmayent       number(5)      ,/* 企業編號 */
mmaysite       varchar2(10)      ,/* 營運據點 */
mmayunit       varchar2(10)      ,/* 應用組織 */
mmaydocno       varchar2(20)      ,/* 單據編號 */
mmaydocdt       date      ,/* 單據日期 */
mmay000       varchar2(10)      ,/* 資料類型 */
mmay001       varchar2(10)      ,/* 發行組織 */
mmay002       varchar2(10)      ,/* 領出組織 */
mmay003       varchar2(10)      ,/* 領出庫位 */
mmaystus       varchar2(10)      ,/* 狀態碼 */
mmayownid       varchar2(20)      ,/* 資料所有者 */
mmayowndp       varchar2(10)      ,/* 資料所屬部門 */
mmaycrtid       varchar2(20)      ,/* 資料建立者 */
mmaycrtdp       varchar2(10)      ,/* 資料建立部門 */
mmaycrtdt       timestamp(0)      ,/* 資料創建日 */
mmaymodid       varchar2(20)      ,/* 資料修改者 */
mmaymoddt       timestamp(0)      ,/* 最近修改日 */
mmaycnfid       varchar2(20)      ,/* 資料確認者 */
mmaycnfdt       timestamp(0)      ,/* 資料確認日 */
mmayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmayud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmay_t add constraint mmay_pk primary key (mmayent,mmaydocno) enable validate;

create unique index mmay_pk on mmay_t (mmayent,mmaydocno);

grant select on mmay_t to tiptop;
grant update on mmay_t to tiptop;
grant delete on mmay_t to tiptop;
grant insert on mmay_t to tiptop;

exit;
