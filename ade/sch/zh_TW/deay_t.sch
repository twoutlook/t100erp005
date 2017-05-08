/* 
================================================================================
檔案代號:deay_t
檔案名稱:銀行卡第三方卡對帳單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table deay_t
(
deayent       number(5)      ,/* 企業編號 */
deaysite       varchar2(10)      ,/* 營運據點 */
deayunit       varchar2(10)      ,/* 應用組織 */
deaydocno       varchar2(20)      ,/* 單據編號 */
deaydocdt       date      ,/* 單據日期 */
deay001       varchar2(10)      ,/* 對帳款別類型 */
deay002       varchar2(10)      ,/* 對帳款別編號 */
deay003       date      ,/* 對帳日期 */
deay004       varchar2(10)      ,/* 對帳部門 */
deay005       varchar2(20)      ,/* 對帳人員 */
deay006       varchar2(10)      ,/* 幣別 */
deayownid       varchar2(20)      ,/* 資料所有者 */
deayowndp       varchar2(10)      ,/* 資料所屬部門 */
deaycrtid       varchar2(20)      ,/* 資料建立者 */
deaycrtdp       varchar2(10)      ,/* 資料建立部門 */
deaycrtdt       timestamp(0)      ,/* 資料創建日 */
deaymodid       varchar2(20)      ,/* 資料修改者 */
deaymoddt       timestamp(0)      ,/* 最近修改日 */
deaycnfid       varchar2(20)      ,/* 資料確認者 */
deaycnfdt       timestamp(0)      ,/* 資料確認日 */
deaypstid       varchar2(20)      ,/* 資料過帳者 */
deaypstdt       timestamp(0)      ,/* 資料過帳日 */
deaystus       varchar2(10)      ,/* 狀態碼 */
deayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deayud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deay_t add constraint deay_pk primary key (deayent,deaydocno) enable validate;

create unique index deay_pk on deay_t (deayent,deaydocno);

grant select on deay_t to tiptop;
grant update on deay_t to tiptop;
grant delete on deay_t to tiptop;
grant insert on deay_t to tiptop;

exit;
