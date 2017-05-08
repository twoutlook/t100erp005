/* 
================================================================================
檔案代號:prbq_t
檔案名稱:門店商品削價單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prbq_t
(
prbqent       number(5)      ,/* 企業編號 */
prbqunit       varchar2(10)      ,/* 應用組織 */
prbqsite       varchar2(10)      ,/* 營運據點 */
prbqdocno       varchar2(20)      ,/* 單據編號 */
prbqdocdt       date      ,/* 單據日期 */
prbq001       varchar2(10)      ,/* 管理品類 */
prbq002       date      ,/* 開始日期 */
prbq003       date      ,/* 結束日期 */
prbq004       varchar2(20)      ,/* 人員 */
prbq005       varchar2(10)      ,/* 部門 */
prbq006       varchar2(255)      ,/* 備註 */
prbqstus       varchar2(10)      ,/* 狀態碼 */
prbqownid       varchar2(20)      ,/* 資料所有者 */
prbqowndp       varchar2(10)      ,/* 資料所屬部門 */
prbqcrtid       varchar2(20)      ,/* 資料建立者 */
prbqcrtdp       varchar2(10)      ,/* 資料建立部門 */
prbqcrtdt       timestamp(0)      ,/* 資料創建日 */
prbqmodid       varchar2(20)      ,/* 資料修改者 */
prbqmoddt       timestamp(0)      ,/* 最近修改日 */
prbqcnfid       varchar2(20)      ,/* 資料確認者 */
prbqcnfdt       timestamp(0)      ,/* 資料確認日 */
prbqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbq_t add constraint prbq_pk primary key (prbqent,prbqdocno) enable validate;

create  index prbq_n on prbq_t (prbqent,prbqsite,prbqdocno,prbq002);
create unique index prbq_pk on prbq_t (prbqent,prbqdocno);

grant select on prbq_t to tiptop;
grant update on prbq_t to tiptop;
grant delete on prbq_t to tiptop;
grant insert on prbq_t to tiptop;

exit;
