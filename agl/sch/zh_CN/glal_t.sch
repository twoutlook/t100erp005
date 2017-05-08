/* 
================================================================================
檔案代號:glal_t
檔案名稱:常用分攤傳票單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table glal_t
(
glalent       number(5)      ,/* 企業編號 */
glalownid       varchar2(20)      ,/* 資料所有者 */
glalowndp       varchar2(10)      ,/* 資料所屬部門 */
glalcrtid       varchar2(20)      ,/* 資料建立者 */
glalcrtdp       varchar2(10)      ,/* 資料建立部門 */
glalcrtdt       timestamp(0)      ,/* 資料創建日 */
glalmodid       varchar2(20)      ,/* 資料修改者 */
glalmoddt       timestamp(0)      ,/* 最近修改日 */
glalcnfid       varchar2(20)      ,/* 資料確認者 */
glalcnfdt       timestamp(0)      ,/* 資料確認日 */
glalpstid       varchar2(20)      ,/* 資料過帳者 */
glalpstdt       timestamp(0)      ,/* 資料過帳日 */
glalstus       varchar2(10)      ,/* 狀態碼 */
glalld       varchar2(5)      ,/* 帳別(套)編號 */
glalcomp       varchar2(10)      ,/* 營運據點(法人) */
glaldocno       varchar2(20)      ,/* 分攤編號 */
glaldocdt       date      ,/* 單據日期 */
glal001       varchar2(1)      ,/* 分攤性質 */
glal002       varchar2(10)      ,/* 分攤類別 */
glal003       number(10,0)      ,/* 自動產生順序 */
glal004       date      ,/* 起始日期 */
glal005       date      ,/* 截止日期 */
glal006       varchar2(5)      ,/* 傳票單別 */
glal007       date      ,/* 上次產生日期 */
glalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glal_t add constraint glal_pk primary key (glalent,glalld,glaldocno) enable validate;

create unique index glal_pk on glal_t (glalent,glalld,glaldocno);

grant select on glal_t to tiptop;
grant update on glal_t to tiptop;
grant delete on glal_t to tiptop;
grant insert on glal_t to tiptop;

exit;
