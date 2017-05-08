/* 
================================================================================
檔案代號:crce_t
檔案名稱:客戶回訪記錄維護單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table crce_t
(
crceent       number(5)      ,/* 企業編號 */
crcesite       varchar2(10)      ,/* 營運據點 */
crceunit       varchar2(10)      ,/* 應用組織 */
crcedocno       varchar2(20)      ,/* 回訪單號 */
crcedocdt       date      ,/* 回訪日期 */
crcestus       varchar2(10)      ,/* 狀態碼 */
crce001       varchar2(30)      ,/* 會員卡號 */
crce002       varchar2(30)      ,/* 會員編號 */
crce003       varchar2(255)      ,/* 會員姓名 */
crce004       varchar2(20)      ,/* 客戶編號 */
crce005       varchar2(80)      ,/* 客戶簡稱 */
crce006       varchar2(20)      ,/* 聯繫人 */
crce007       varchar2(30)      ,/* 聯繫電話 */
crce008       varchar2(20)      ,/* 調查問卷編號 */
crce009       number(15,3)      ,/* 分數 */
crce010       varchar2(4000)      ,/* 回訪記錄 */
crceownid       varchar2(20)      ,/* 資料所有者 */
crceowndp       varchar2(10)      ,/* 資料所屬部門 */
crcecrtid       varchar2(20)      ,/* 資料建立者 */
crcecrtdp       varchar2(10)      ,/* 資料建立部門 */
crcecrtdt       timestamp(0)      ,/* 資料創建日 */
crcemodid       varchar2(20)      ,/* 資料修改者 */
crcemoddt       timestamp(0)      ,/* 最近修改日 */
crcecnfid       varchar2(20)      ,/* 資料確認者 */
crcecnfdt       timestamp(0)      ,/* 資料確認日 */
crceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crce_t add constraint crce_pk primary key (crceent,crcedocno) enable validate;

create unique index crce_pk on crce_t (crceent,crcedocno);

grant select on crce_t to tiptop;
grant update on crce_t to tiptop;
grant delete on crce_t to tiptop;
grant insert on crce_t to tiptop;

exit;
