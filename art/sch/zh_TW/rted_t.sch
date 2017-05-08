/* 
================================================================================
檔案代號:rted_t
檔案名稱:市場調查資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rted_t
(
rtedent       number(5)      ,/* 企業編號 */
rtedsite       varchar2(10)      ,/* 營運據點 */
rteddocno       varchar2(20)      ,/* 單據編號 */
rteddocdt       date      ,/* 單據日期 */
rted001       varchar2(20)      ,/* 計劃單號 */
rted002       varchar2(10)      ,/* 市調門店 */
rted003       varchar2(10)      ,/* 競爭門店 */
rted004       number(10)      ,/* 市調類型 */
rted005       date      ,/* 開始日期 */
rted006       date      ,/* 結束日期 */
rted007       varchar2(20)      ,/* 調查人員 */
rted008       varchar2(255)      ,/* 備註 */
rtedstus       varchar2(10)      ,/* 狀態碼 */
rtedownid       varchar2(20)      ,/* 資料所有者 */
rtedowndp       varchar2(10)      ,/* 資料所屬部門 */
rtedcrtid       varchar2(20)      ,/* 資料建立者 */
rtedcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtedcrtdt       timestamp(0)      ,/* 資料創建日 */
rtedmodid       varchar2(20)      ,/* 資料修改者 */
rtedmoddt       timestamp(0)      ,/* 最近修改日 */
rtedcnfid       varchar2(20)      ,/* 資料確認者 */
rtedcnfdt       timestamp(0)      ,/* 資料確認日 */
rtedunit       varchar2(10)      ,/* 應用組織 */
rtedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtedud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rted_t add constraint rted_pk primary key (rtedent,rteddocno) enable validate;

create unique index rted_pk on rted_t (rtedent,rteddocno);

grant select on rted_t to tiptop;
grant update on rted_t to tiptop;
grant delete on rted_t to tiptop;
grant insert on rted_t to tiptop;

exit;
