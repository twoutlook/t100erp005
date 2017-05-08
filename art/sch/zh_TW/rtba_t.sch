/* 
================================================================================
檔案代號:rtba_t
檔案名稱:庫區異動單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtba_t
(
rtbaent       number(5)      ,/* 企業編號 */
rtbadocno       varchar2(20)      ,/* 申請單號 */
rtbadocdt       date      ,/* 單據日期 */
rtbasite       varchar2(10)      ,/* 營運據點 */
rtbaunit       varchar2(10)      ,/* 應用組織 */
rtba000       varchar2(10)      ,/* 申請類別 */
rtba001       varchar2(10)      ,/* no use */
rtba002       varchar2(20)      ,/* 申請人員 */
rtba003       varchar2(10)      ,/* 申請部門 */
rtbastus       varchar2(10)      ,/* 狀態碼 */
rtbaownid       varchar2(20)      ,/* 資料所有者 */
rtbaowndp       varchar2(10)      ,/* 資料所屬部門 */
rtbacrtid       varchar2(20)      ,/* 資料建立者 */
rtbacrtdp       varchar2(10)      ,/* 資料建立部門 */
rtbacrtdt       timestamp(0)      ,/* 資料創建日 */
rtbamodid       varchar2(20)      ,/* 資料修改者 */
rtbamoddt       timestamp(0)      ,/* 最近修改日 */
rtbacnfid       varchar2(20)      ,/* 資料確認者 */
rtbacnfdt       timestamp(0)      ,/* 資料確認日 */
rtbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtba_t add constraint rtba_pk primary key (rtbaent,rtbadocno) enable validate;

create unique index rtba_pk on rtba_t (rtbaent,rtbadocno);

grant select on rtba_t to tiptop;
grant update on rtba_t to tiptop;
grant delete on rtba_t to tiptop;
grant insert on rtba_t to tiptop;

exit;
