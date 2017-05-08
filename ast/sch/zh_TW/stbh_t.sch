/* 
================================================================================
檔案代號:stbh_t
檔案名稱:促銷協議資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stbh_t
(
stbhent       number(5)      ,/* 企業編號 */
stbhsite       varchar2(10)      ,/* 營運組織 */
stbhunit       varchar2(10)      ,/* 應用組織 */
stbhdocno       varchar2(20)      ,/* 單據編號 */
stbhdocdt       date      ,/* 單據日期 */
stbh001       varchar2(20)      ,/* 合約編號 */
stbh002       varchar2(10)      ,/* 供應商編號 */
stbh003       varchar2(10)      ,/* 經營方式 */
stbh004       varchar2(10)      ,/* 結算方式 */
stbh005       varchar2(10)      ,/* 結算類型 */
stbh006       number(20,6)      ,/* 費用承擔比例 */
stbh007       number(20,6)      ,/* 補差承擔比例 */
stbh008       varchar2(20)      ,/* 業務人員 */
stbh009       varchar2(10)      ,/* 業務部門 */
stbhstus       varchar2(10)      ,/* 狀態碼 */
stbhownid       varchar2(20)      ,/* 資料所有者 */
stbhowndp       varchar2(10)      ,/* 資料所有部門 */
stbhcrtid       varchar2(20)      ,/* 資料建立者 */
stbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
stbhcrtdt       timestamp(0)      ,/* 資料創建日 */
stbhmodid       varchar2(20)      ,/* 資料修改者 */
stbhmoddt       timestamp(0)      ,/* 最近修改日 */
stbhcnfid       varchar2(20)      ,/* 資料確認者 */
stbhcnfdt       timestamp(0)      ,/* 資料確認日 */
stbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stbh_t add constraint stbh_pk primary key (stbhent,stbhdocno) enable validate;

create unique index stbh_pk on stbh_t (stbhent,stbhdocno);

grant select on stbh_t to tiptop;
grant update on stbh_t to tiptop;
grant delete on stbh_t to tiptop;
grant insert on stbh_t to tiptop;

exit;
