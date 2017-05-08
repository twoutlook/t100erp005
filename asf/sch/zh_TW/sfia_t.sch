/* 
================================================================================
檔案代號:sfia_t
檔案名稱:工單製程重工轉出檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table sfia_t
(
sfiaent       number(5)      ,/* 企業編號 */
sfiasite       varchar2(10)      ,/* 營運據點 */
sfiadocno       varchar2(20)      ,/* 單號 */
sfiadocdt       date      ,/* 單據日期 */
sfia001       varchar2(20)      ,/* 申請人員 */
sfia002       varchar2(10)      ,/* 部門 */
sfia003       varchar2(20)      ,/* 工單單號 */
sfia004       number(10,0)      ,/* Run Card */
sfia005       varchar2(10)      ,/* 轉出作業編號 */
sfia006       varchar2(10)      ,/* 轉出作業序 */
sfia007       number(20,6)      ,/* 轉出數量 */
sfia008       number(10,0)      ,/* 轉入Run Card */
sfia009       varchar2(255)      ,/* 備註 */
sfiaownid       varchar2(20)      ,/* 資料所有者 */
sfiaowndp       varchar2(10)      ,/* 資料所有部門 */
sfiacrtid       varchar2(20)      ,/* 資料建立者 */
sfiacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfiacrtdt       timestamp(0)      ,/* 資料創建日 */
sfiamodid       varchar2(20)      ,/* 資料修改者 */
sfiamoddt       timestamp(0)      ,/* 最近修改日 */
sfiacnfid       varchar2(20)      ,/* 資料確認者 */
sfiacnfdt       timestamp(0)      ,/* 資料確認日 */
sfiastus       varchar2(10)      ,/* 狀態碼 */
sfiaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfiaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfiaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfiaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfiaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfiaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfiaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfiaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfiaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfiaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfiaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfiaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfiaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfiaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfiaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfiaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfiaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfiaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfiaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfiaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfiaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfiaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfiaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfiaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfiaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfiaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfiaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfiaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfiaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfiaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
sfia010       varchar2(10)      ,/* 轉入作業編號 */
sfia011       varchar2(10)      ,/* 轉入作業序 */
sfia012       varchar2(40)      ,/* 生產料號 */
sfia013       varchar2(30)      ,/* BOM特性 */
sfia014       varchar2(256)      ,/* 產品特徵 */
sfia015       varchar2(10)      /* 生產計劃 */
);
alter table sfia_t add constraint sfia_pk primary key (sfiaent,sfiadocno) enable validate;

create unique index sfia_pk on sfia_t (sfiaent,sfiadocno);

grant select on sfia_t to tiptop;
grant update on sfia_t to tiptop;
grant delete on sfia_t to tiptop;
grant insert on sfia_t to tiptop;

exit;
