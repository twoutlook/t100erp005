/* 
================================================================================
檔案代號:stbl_t
檔案名稱:DM促銷單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stbl_t
(
stblent       number(5)      ,/* 企業編號 */
stblsite       varchar2(10)      ,/* 營運組織 */
stblunit       varchar2(10)      ,/* 應用組織 */
stbldocno       varchar2(20)      ,/* 單據編號 */
stbldocdt       date      ,/* 單據日期 */
stbl001       varchar2(20)      ,/* 業務人員 */
stbl002       varchar2(10)      ,/* 業務部門 */
stblstus       varchar2(10)      ,/* 狀態碼 */
stblownid       varchar2(20)      ,/* 資料所有者 */
stblowndp       varchar2(10)      ,/* 資料所有部門 */
stblcrtid       varchar2(20)      ,/* 資料建立者 */
stblcrtdp       varchar2(10)      ,/* 資料建立部門 */
stblcrtdt       timestamp(0)      ,/* 資料創建日 */
stblmodid       varchar2(20)      ,/* 資料修改者 */
stblmoddt       timestamp(0)      ,/* 最近修改日 */
stblcnfid       varchar2(20)      ,/* 資料確認者 */
stblcnfdt       timestamp(0)      ,/* 資料確認日 */
stbl003       varchar2(20)      ,/*   */
stbl004       varchar2(10)      ,/*   */
stbl005       varchar2(10)      ,/*   */
stbl006       varchar2(10)      ,/*   */
stbl007       varchar2(10)      ,/*   */
stbl008       number(20,6)      ,/*   */
stbl009       number(20,6)      ,/*   */
stblud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stblud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stblud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stblud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stblud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stblud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stblud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stblud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stblud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stblud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stblud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stblud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stblud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stblud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stblud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stblud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stblud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stblud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stblud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stblud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stblud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stblud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stblud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stblud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stblud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stblud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stblud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stblud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stblud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stblud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stbl_t add constraint stbl_pk primary key (stblent,stbldocno) enable validate;

create unique index stbl_pk on stbl_t (stblent,stbldocno);

grant select on stbl_t to tiptop;
grant update on stbl_t to tiptop;
grant delete on stbl_t to tiptop;
grant insert on stbl_t to tiptop;

exit;
