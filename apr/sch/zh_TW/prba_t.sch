/* 
================================================================================
檔案代號:prba_t
檔案名稱:競爭門店資料維護表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prba_t
(
prbaent       number(5)      ,/* 企業編號 */
prba001       varchar2(10)      ,/* 市調門店編號 */
prba002       varchar2(10)      ,/* 競爭門店編號 */
prba003       varchar2(80)      ,/* 競爭門店名稱 */
prba004       number(10,0)      ,/* 競爭門店面積(平方米) */
prba005       number(10,0)      ,/* 競爭門店人數 */
prba006       varchar2(255)      ,/* 競爭門店地址 */
prba007       varchar2(4000)      ,/* 備註 */
prbastus       varchar2(10)      ,/* 狀態 */
prbaownid       varchar2(20)      ,/* 資料所有者 */
prbaowndp       varchar2(10)      ,/* 資料所屬部門 */
prbacrtid       varchar2(20)      ,/* 資料建立者 */
prbacrtdp       varchar2(10)      ,/* 資料建立部門 */
prbacrtdt       timestamp(0)      ,/* 資料創建日 */
prbamodid       varchar2(20)      ,/* 資料修改者 */
prbamoddt       timestamp(0)      ,/* 最近修改日 */
prbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prba_t add constraint prba_pk primary key (prbaent,prba001,prba002) enable validate;

create unique index prba_pk on prba_t (prbaent,prba001,prba002);

grant select on prba_t to tiptop;
grant update on prba_t to tiptop;
grant delete on prba_t to tiptop;
grant insert on prba_t to tiptop;

exit;
