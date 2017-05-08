/* 
================================================================================
檔案代號:pmeh_t
檔案名稱:採購變更交期明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmeh_t
(
pmehent       number(5)      ,/* 企業編號 */
pmehsite       varchar2(10)      ,/* 營運據點 */
pmehdocno       varchar2(20)      ,/* 採購變更單號 */
pmehseq       number(10,0)      ,/* 採購項次 */
pmehseq1       number(10,0)      ,/* 項序 */
pmehseq2       number(10,0)      ,/* 分批序 */
pmeh001       varchar2(40)      ,/* 料件編號 */
pmeh002       varchar2(256)      ,/* 產品特徵 */
pmeh003       varchar2(10)      ,/* 子件特性 */
pmeh004       varchar2(10)      ,/* 採購單位 */
pmeh005       number(20,6)      ,/* 採購總數量 */
pmeh006       number(20,6)      ,/* 分批採購數量 */
pmeh007       number(20,6)      ,/* 摺合主件數量 */
pmeh008       number(20,6)      ,/* QPA */
pmeh009       varchar2(10)      ,/* 交期類型 */
pmeh010       varchar2(10)      ,/* 收貨時段 */
pmeh011       date      ,/* 出貨日期 */
pmeh012       date      ,/* 到廠日期 */
pmeh013       date      ,/* 到庫日期 */
pmeh014       varchar2(1)      ,/* MRP交期凍結 */
pmeh015       number(20,6)      ,/* 已收貨量 */
pmeh016       number(20,6)      ,/* 驗退量 */
pmeh017       number(20,6)      ,/* 倉退換貨量 */
pmeh019       number(20,6)      ,/* 已入庫量 */
pmeh020       number(20,6)      ,/* VMI請款量 */
pmeh021       varchar2(10)      ,/* 交貨狀態 */
pmeh022       number(20,6)      ,/* 參考價格 */
pmeh023       varchar2(10)      ,/* 稅別 */
pmeh024       number(5,2)      ,/* 稅率 */
pmeh025       varchar2(20)      ,/* 電子採購單號 */
pmeh026       varchar2(20)      ,/* 最近修改人員 */
pmeh027       date      ,/* 最近修改時間 */
pmeh028       varchar2(10)      ,/* 分批參考單位 */
pmeh029       number(20,6)      ,/* 分批參考數量 */
pmeh030       varchar2(10)      ,/* 分批計價單位 */
pmeh031       number(20,6)      ,/* 分批計價數量 */
pmeh032       number(20,6)      ,/* 分批未稅金額 */
pmeh033       number(20,6)      ,/* 分批含稅金額 */
pmeh034       number(20,6)      ,/* 分批稅額 */
pmeh035       varchar2(10)      ,/* 初始營運據點 */
pmeh036       varchar2(20)      ,/* 初始來源單號 */
pmeh037       number(10,0)      ,/* 初始來源項次 */
pmeh038       number(10,0)      ,/* 初始項序 */
pmeh039       number(10,0)      ,/* 初始分批序 */
pmeh040       number(20,6)      ,/* 倉退量 */
pmeh900       number(10,0)      ,/* 變更序 */
pmeh901       varchar2(1)      ,/* 變更類型 */
pmehud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmehud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmehud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmehud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmehud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmehud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmehud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmehud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmehud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmehud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmehud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmehud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmehud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmehud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmehud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmehud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmehud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmehud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmehud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmehud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmehud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmehud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmehud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmehud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmehud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmehud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmehud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmehud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmehud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmehud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmeh200       varchar2(10)      ,/* 分批包裝單位 */
pmeh201       number(20,6)      /* 分批包裝數量 */
);
alter table pmeh_t add constraint pmeh_pk primary key (pmehent,pmehdocno,pmehseq,pmehseq1,pmehseq2,pmeh900) enable validate;

create unique index pmeh_pk on pmeh_t (pmehent,pmehdocno,pmehseq,pmehseq1,pmehseq2,pmeh900);

grant select on pmeh_t to tiptop;
grant update on pmeh_t to tiptop;
grant delete on pmeh_t to tiptop;
grant insert on pmeh_t to tiptop;

exit;
