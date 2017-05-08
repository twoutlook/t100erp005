/* 
================================================================================
檔案代號:glba_t
檔案名稱:帳別使用者設限檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glba_t
(
glbaent       number(5)      ,/* 企業編號 */
glbaownid       varchar2(20)      ,/* 資料所有者 */
glbaowndp       varchar2(10)      ,/* 資料所屬部門 */
glbacrtid       varchar2(20)      ,/* 資料建立者 */
glbacrtdp       varchar2(10)      ,/* 資料建立部門 */
glbacrtdt       timestamp(0)      ,/* 資料創建日 */
glbamodid       varchar2(20)      ,/* 資料修改者 */
glbamoddt       timestamp(0)      ,/* 最近修改日 */
glbastus       varchar2(10)      ,/* 狀態碼 */
glbald       varchar2(5)      ,/* 帳別 */
glba001       varchar2(20)      ,/* 使用者編號 */
glbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glba_t add constraint glba_pk primary key (glbaent,glbald,glba001) enable validate;

create unique index glba_pk on glba_t (glbaent,glbald,glba001);

grant select on glba_t to tiptop;
grant update on glba_t to tiptop;
grant delete on glba_t to tiptop;
grant insert on glba_t to tiptop;

exit;
