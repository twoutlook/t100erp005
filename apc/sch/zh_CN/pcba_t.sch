/* 
================================================================================
檔案代號:pcba_t
檔案名稱:觸屏分類基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcba_t
(
pcbaent       number(5)      ,/* 企業編號 */
pcbaunit       varchar2(10)      ,/* 應用組織 */
pcba001       varchar2(10)      ,/* 觸屏分類編號 */
pcba002       varchar2(10)      ,/* 上層觸屏分類編號 */
pcba003       number(5,0)      ,/* 層級 */
pcba004       number(5,0)      ,/* 下級觸屏分類數 */
pcba005       varchar2(10)      ,/* 所屬一級觸屏分類 */
pcbastus       varchar2(10)      ,/* 狀態碼 */
pcbaownid       varchar2(20)      ,/* 資料所有者 */
pcbaowndp       varchar2(10)      ,/* 資料所屬部門 */
pcbacrtid       varchar2(20)      ,/* 資料建立者 */
pcbacrtdp       varchar2(10)      ,/* 資料建立部門 */
pcbacrtdt       timestamp(0)      ,/* 資料創建日 */
pcbamodid       varchar2(20)      ,/* 資料修改者 */
pcbamoddt       timestamp(0)      ,/* 最近修改日 */
pcbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcba_t add constraint pcba_pk primary key (pcbaent,pcba001) enable validate;

create unique index pcba_pk on pcba_t (pcbaent,pcba001);

grant select on pcba_t to tiptop;
grant update on pcba_t to tiptop;
grant delete on pcba_t to tiptop;
grant insert on pcba_t to tiptop;

exit;
